every 1.minute do
  runner "IncomingMessagesWorker.perform_async"
end
