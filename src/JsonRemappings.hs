module JsonRemappings where

ownerRemappings :: String -> String
ownerRemappings "owner_type" = "type"
ownerRemappings "owner_id" = "id"
ownerRemappings "owner_node_id" = "node_id"
ownerRemappings "owner_url" = "url"
ownerRemappings "owner_html_url" = "html_url"
ownerRemappings "owner_events_url" = "events_url"
ownerRemappings name = name

repoRemappings :: String -> String
repoRemappings "repo_id" = "id"
repoRemappings "repo_node_id" = "node_id"
repoRemappings "repo_url" = "url"
repoRemappings "repo_html_url" = "html_url"
repoRemappings "repo_events_url" = "events_url"
repoRemappings name = name
