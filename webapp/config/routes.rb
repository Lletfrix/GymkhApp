Rails.application.routes.draw do
  resources :games do
		member do
			get 'share'
			get 'leaderboard'
		end
	end

  resources :challenges do
		member do
			post 'complete'
		end
		collection do
			get 'first'
		end
	end
  devise_for :users

  root to: 'home#welcome'

end
