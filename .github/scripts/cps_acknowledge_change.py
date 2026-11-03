#!/usr/bin/env python3
import json
import os
import re
import sys

import requests
from akamai.edgegrid import EdgeGridAuth


def require_env(name: str) -> str:
    value = os.environ.get(name, "").strip()
    if not value:
        raise RuntimeError(f"Missing required environment variable: {name}")
    return value


def extract_change_path(first_pending):
    if isinstance(first_pending, dict):
        return first_pending.get("input") or first_pending.get("location") or ""
    return str(first_pending)


def main() -> int:
    if len(sys.argv) != 2:
        print("Usage: cps_acknowledge_change.py <enrollment_id>", file=sys.stderr)
        return 2

    enrollment_id = sys.argv[1].strip()
    if not enrollment_id:
        print("enrollment_id is empty", file=sys.stderr)
        return 2

    host = require_env("AKAMAI_HOST").rstrip("/")
    client_token = require_env("AKAMAI_CLIENT_TOKEN")
    client_secret = require_env("AKAMAI_CLIENT_SECRET")
    access_token = require_env("AKAMAI_ACCESS_TOKEN")
    account_key = os.environ.get("AKAMAI_ACCOUNT_KEY", "").strip()

    base_url = host if host.startswith("https://") else f"https://{host}"

    session = requests.Session()
    session.auth = EdgeGridAuth(
        client_token=client_token,
        client_secret=client_secret,
        access_token=access_token,
    )

    params = {}
    if account_key:
        params["accountSwitchKey"] = account_key

    enrollment_url = f"{base_url}/cps/v2/enrollments/{enrollment_id}"
    enrollment_resp = session.get(
        enrollment_url,
        params=params,
        headers={"Accept": "application/vnd.akamai.cps.enrollment.v7+json"},
        timeout=60,
    )
    enrollment_resp.raise_for_status()

    enrollment_json = enrollment_resp.json()
    pending_changes = enrollment_json.get("pendingChanges") or []

    if not pending_changes:
        print("No pendingChanges found; acknowledgement skipped.")
        return 0

    change_path = extract_change_path(pending_changes[0])
    match = re.search(r"/changes/(\d+)", change_path)
    if not match:
        raise RuntimeError(
            f"Unable to extract changeId from pendingChanges item: {change_path}"
        )

    change_id = match.group(1)

    ack_url = (
        f"{base_url}/cps/v2/enrollments/{enrollment_id}/changes/{change_id}"
        "/input/update/post-verification-warnings-ack"
    )

    ack_resp = session.post(
        ack_url,
        params=params,
        headers={
            "content-type": "application/vnd.akamai.cps.acknowledgement.v1+json",
            "accept": "application/vnd.akamai.cps.change-id.v1+json",
        },
        data=json.dumps({"acknowledgement": "acknowledge"}),
        timeout=60,
    )
    ack_resp.raise_for_status()

    print(f"Acknowledged CPS deletion id {change_id} for enrollment {enrollment_id}.")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except Exception as exc:
        print(f"CPS acknowledgement failed: {exc}", file=sys.stderr)
        raise
