
data "akamai_property_rules_builder" "rule_prefetching" {
  rules_v2026_02_16 {
    name                  = "Prefetching"
    comments              = "Instruct edge servers to retrieve embedded resources before the browser requests them."
    criteria_must_satisfy = "all"
    children = [
      data.akamai_property_rules_builder.rule_prefetching_objects.json,
      data.akamai_property_rules_builder.rule_prefetchable_objects.json,
    ]
  }
}

data "akamai_property_rules_builder" "rule_prefetching_objects" {
  rules_v2026_02_16 {
    name                  = "Prefetching objects"
    comments              = "Define for which HTML pages prefetching should be enabled."
    criteria_must_satisfy = "all"
    behavior {
      prefetch {
        enabled = true
      }
    }
    children = [
      data.akamai_property_rules_builder.rule_bots.json,
    ]
  }
}

data "akamai_property_rules_builder" "rule_prefetchable_objects" {
  rules_v2026_02_16 {
    name                  = "Prefetchable objects"
    comments              = "Define which resources should be prefetched."
    criteria_must_satisfy = "all"
    criterion {
      file_extension {
        match_case_sensitive = false
        match_operator       = "IS_ONE_OF"
        values               = ["css", "js", "jpg", "jpeg", "jp2", "png", "gif", "svg", "svgz", "webp", "eot", "woff", "woff2", "otf", "ttf", ]
      }
    }
    behavior {
      prefetchable {
        enabled = true
      }
    }
  }
}

data "akamai_property_rules_builder" "rule_bots" {
  rules_v2026_02_16 {
    name                  = "Bots"
    comments              = "Disable prefetching for specific clients identifying themselves as bots and crawlers. This avoids requesting unnecessary resources from the origin."
    criteria_must_satisfy = "all"
    criterion {
      user_agent {
        match_case_sensitive = false
        match_operator       = "IS_ONE_OF"
        match_wildcard       = true
        values               = ["*bot*", "*crawl*", "*spider*", ]
      }
    }
    behavior {
      prefetch {
        enabled = false
      }
    }
  }
}
