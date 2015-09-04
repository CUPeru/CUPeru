if defined? BetterErrors
    BetterErrors.editor = proc { |file, line| "viminiterm://open?url=file://#{file}&line=#{line}" }
end
