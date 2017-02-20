unless Rails.env.production?
  ENV['AUTH_SECRET']='auth-secret'
end
