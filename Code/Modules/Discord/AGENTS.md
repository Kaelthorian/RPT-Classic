# Instructions for `Code/Modules/Discord`

- Existing committed webhook URLs are secrets and must never be printed, copied, or
  contacted. Assume they are compromised and require provider-side rotation.
- New code must obtain endpoint configuration outside tracked source and fail closed
  when it is absent.
- Do not use `usr.client` inside reusable hook procs. Pass the actor/client explicitly
  and handle missing/disconnected clients.
- Sanitize and length-limit all user-controlled fields. Prevent arbitrary destination
  URLs, mass mentions, unsafe markdown/HTML, and credential logging.
- Tests must stub the HTTP layer or use a deliberately disposable local/test endpoint.
  Never send a real Discord request.
- Verify network failure, missing config, invalid actor, and rate-limit behavior without
  blocking gameplay or crashing the client.
