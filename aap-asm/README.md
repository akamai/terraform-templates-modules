# Modules to create an AAP+ASM configuration

The Terraform Modules contained in this repository help you manage different resources required to create an AAP+ASM Configuration as per best practices. Supports **multiple security policies** per configuration, each with independently configurable protection actions.

## Modules

| Module | Cardinality | Purpose |
|--------|-------------|---------|
| **activate-security** | Once | Activate the security configuration on staging and production networks |
| **client-lists** | Once | Create and manage client lists (IP block, GEO block, bypass lists) |
| **security-config** | Once | Create the security configuration, advanced settings, rate policies, and reputation profiles |
| **security-policy** | Per policy (`for_each`) | Create security policies with match targets, WAF, DoS, IP/GEO firewall, client reputation, and bot management |

## Multi-Policy Architecture

```
security-config (singleton)        security-policy (for_each)
├── Configuration                  ├── Policy + match target
├── Advanced settings              ├── Protection toggles
├── Rate policies                  ├── WAF attack group actions
├── Reputation profiles            ├── Rate policy actions
└── Bypass lists                   ├── IP/Geo firewall
                                   ├── Penalty box + slow POST
                                   ├── Reputation profile actions
                                   └── Bot management settings + actions
```

Each policy inherits from a `policy_defaults` baseline and can override any field independently.

