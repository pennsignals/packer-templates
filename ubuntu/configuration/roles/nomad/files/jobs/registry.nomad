{
    "Job": {
        "Stop": null,
        "Region": null,
        "Namespace": null,
        "ID": "registry",
        "ParentID": null,
        "Name": "registry",
        "Type": null,
        "Priority": null,
        "AllAtOnce": null,
        "Datacenters": [
            "dc1"
        ],
        "Constraints": null,
        "TaskGroups": [
            {
                "Name": "registry",
                "Count": null,
                "Constraints": null,
                "Tasks": [
                    {
                        "Name": "registry",
                        "Driver": "docker",
                        "User": "",
                        "Config": {
                            "image": "registry",
                            "network_mode": "host",
                            "port_map": [
                                {
                                    "registry": 443
                                }
                            ],
                            "volumes": [
                                "/etc/ssl/private:/etc/ssl/private:ro",
                                "/usr/local/share/ca-certificates:/usr/local/share/ca-certificates:ro"
                            ]
                        },
                        "Constraints": null,
                        "Env": {
                            "REGISTRY_HTTP_ADDR": "0.0.0.0:443",
                            "REGISTRY_HTTP_TLS_CERTIFICATE": "/usr/local/share/ca-certificates/ansible.crt",
                            "REGISTRY_HTTP_TLS_KEY": "/etc/ssl/private/ansible.key"
                        },
                        "Services": [
                            {
                                "Id": "",
                                "Name": "registry",
                                "Tags": null,
                                "PortLabel": "registry",
                                "AddressMode": "",
                                "Checks": [
                                    {
                                        "Id": "",
                                        "Name": "",
                                        "Type": "http",
                                        "Command": "",
                                        "Args": null,
                                        "Path": "/v2/",
                                        "Protocol": "https",
                                        "PortLabel": "",
                                        "AddressMode": "",
                                        "Interval": 10000000000,
                                        "Timeout": 30000000000,
                                        "InitialStatus": "",
                                        "TLSSkipVerify": false,
                                        "Header": null,
                                        "Method": "",
                                        "CheckRestart": null
                                    }
                                ],
                                "CheckRestart": null
                            }
                        ],
                        "Resources": {
                            "CPU": null,
                            "MemoryMB": null,
                            "DiskMB": null,
                            "IOPS": null,
                            "Networks": [
                                {
                                    "Device": "",
                                    "CIDR": "",
                                    "IP": "",
                                    "MBits": null,
                                    "ReservedPorts": [
                                        {
                                            "Label": "registry",
                                            "Value": 443
                                        }
                                    ],
                                    "DynamicPorts": null
                                }
                            ]
                        },
                        "Meta": null,
                        "KillTimeout": null,
                        "LogConfig": null,
                        "Artifacts": null,
                        "Vault": null,
                        "Templates": null,
                        "DispatchPayload": null,
                        "Leader": false,
                        "ShutdownDelay": 0,
                        "KillSignal": ""
                    }
                ],
                "RestartPolicy": null,
                "EphemeralDisk": null,
                "Update": null,
                "Meta": null
            }
        ],
        "Update": null,
        "Periodic": null,
        "ParameterizedJob": null,
        "Payload": null,
        "Meta": null,
        "VaultToken": "myroot",
        "Status": null,
        "StatusDescription": null,
        "Stable": null,
        "Version": null,
        "SubmitTime": null,
        "CreateIndex": null,
        "ModifyIndex": null,
        "JobModifyIndex": null
    }
}
