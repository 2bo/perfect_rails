Rails.application.config.middleware.use OmniAuth::Builder do
    if Rails.env.development? || Rails.env.test?
        provider :github, "5e26d9903d1987b5274f", "ae5d325022b2e5c1a2155bf5cf28ea16ba4705c1"
    else
        provider :github,
            Rails.application.credentials.github[:client_id],
            Rails.application.credentials.github[:client_secret]
    end
end
