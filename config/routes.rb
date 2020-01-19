Rails.application.routes.draw do
  scope :api do
    scope :v1 do
      get 'test', to: 'api/v1/test#secured'
    end
  end
end
