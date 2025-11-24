aws_region  = "us-west-2"
aws_profile = "default"

instance_id = "5d253be2-f961-4d07-a04d-f9e36e6b5a7b"

project_name = "hospital-noso"

environment = "dev"

hours_of_operation = {
  name = "hospital-hours"
  config = [
    { day = "MONDAY", start_time = { hours = 8, minutes = 0 }, end_time = { hours = 17, minutes = 0 } },
    { day = "TUESDAY", start_time = { hours = 8, minutes = 0 }, end_time = { hours = 17, minutes = 0 } },
    { day = "WEDNESDAY", start_time = { hours = 8, minutes = 0 }, end_time = { hours = 17, minutes = 0 } },
    { day = "THURSDAY", start_time = { hours = 8, minutes = 0 }, end_time = { hours = 17, minutes = 0 } },
    { day = "FRIDAY", start_time = { hours = 8, minutes = 0 }, end_time = { hours = 17, minutes = 0 } }
  ]
}

queues = {
  "Appointments" = { description = "Scheduling and appointment changes" }
  "Billing"      = { description = "Insurance and billing support" }
  "NurseLine"    = { description = "Clinical triage and nurse support" }
  "Pharmacy"     = { description = "Refills and pharmacy questions" }
  "Operator"     = { description = "Front desk / receptionist" }
}

routing_profiles = {
  "DefaultAgents" = {
    description            = "Default NOSO hospital routing profile"
    default_outbound_queue = "Operator"
    queue_priorities = [
      { queue_name = "Appointments", priority = 1, delay = 0 },
      { queue_name = "Billing", priority = 2, delay = 0 },
      { queue_name = "NurseLine", priority = 3, delay = 0 },
      { queue_name = "Pharmacy", priority = 4, delay = 0 },
      { queue_name = "Operator", priority = 5, delay = 0 }
    ]
  }
}

flow_modules = {
  "LanguageSelection" = {
    description = "English/Spanish selector"
    file_path   = "flows/language-module.json"
  }
  "HoursCheck" = {
    description = "Business hours module"
    file_path   = "flows/hours-module.json"
  }
  "DepartmentMenu" = {
    description = "Routes to departments"
    file_path   = "flows/dept-menu-module.json"
  }
  "AfterHoursVoicemail" = {
    description = "After hours voicemail drop"
    file_path   = "flows/afterhours-voicemail.json"
  }
}

contact_flows = {
  "MainInbound" = {
    description = "Main Hospital of NOSO inbound IVR entrypoint"
    file_path   = "flows/main-inbound.json"
  }
}
