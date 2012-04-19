class Ability
  include CanCan::Ability

  # NOTE: abilities defined later have higher priority

  def initialize(user)
    if not user # or (user.is_gym? and user.subscription.blank?) or (user.is_gym? and user.subscription.stripe_customer_token.blank?)
#      if provisional_user_id
#        can :manage, DoneDealRequest do |action, request|
#          provisional_user_id && request.provisional_user_id.to_s == provisional_user_id
#        end
#        can :manage, CustomDealRequest do |action, request|
#          provisional_user_id && request.provisional_user_id.to_s == provisional_user_id
#        end
#        can :manage, NewDealRequest do |action, request|
#          provisional_user_id && request.provisional_user_id.to_s == provisional_user_id
#        end
#      end
#      can :create, [CustomDealRequest, DoneDealRequest, NewDealRequest]
#      can :read, PressClipping
#    elsif user.is_admin?
#      can :manage, :all

    elsif (user.is_trainer?) and (user.subscription.blank? or user.subscription.stripe_customer_token.blank?) and user.trainer.gym.blank?
      # Plans
      ################
      can :index, Plan

      # Subscriptions
      ################
      can :create, Subscription

    elsif (user.is_gym?) and (user.subscription.blank? or user.subscription.stripe_customer_token.blank?)
      # Plans
      ################
      can :index, Plan

      # Subscriptions
      ################
      can :create, Subscription

    elsif user # user, non-admin
#      can :manage, :all

      # Subscriptions
      ################
      can :manage, Subscription do |action, subscription|
        subscription  && (subscription.user == user)
      end
      can :create, Subscription
#      can :index, Subscription

      # Plans
      ################
#      can :manage, Plan do |action, plan|
#        plan  && (plan.trainer == user.trainer)
#      end
#      can :create, Plan
      unless user.is_trainer? and user.trainer.gym.blank?
        can :index, Plan
      end

      # Documents
      ################
      can :manage, Document do |action, document|
        document  && (document.trainer == user.trainer)
      end
      can :create, Document
#      can :index, Document

      # Trainers
      ################
      can :manage, Trainer do |action, trainer|
        trainer  && (trainer.user == user or trainer.gym == user.gym)
      end
      can :create, Trainer
      can :index, Trainer

      # Gyms
      ################
      can :manage, Gym do |action, gym|
        gym  && (gym.user == user)
      end
      can :create, Gym
#      can :index, Gym

      # Users
      ################
      can :manage, User do |action, u|
        u  && (u == user)
      end
      can :create, User
      #can :index, User

      # Bodycomps
      ################
      can :manage, Bodycomp do |action, bodycomp|
        bodycomp  && (bodycomp.client.trainer == user.trainer or bodycomp.client == user.client)
      end
      can :create, Bodycomp
      can :index, Bodycomp

      # Clients
      ################
      can :manage, Client do |action, client|
        client  && (client.user == user or client.id == user.client_training_id or client.trainer == user.trainer or client.trainer.gym == user.gym)
      end
      can :create, Client
      can :index, Client

      # Workout_sessions
      ################
      can :manage, WorkoutSession do |action, workout_session|
        workout_session  && (workout_session.user == user or user.client == workout_session.client or workout_session.client.trainer.gym == user.gym or workout_session.client.trainer == user.trainer or user.client_training_id == workout_session.client_id)
      end
      can :create, WorkoutSession
      can :index, WorkoutSession

      # Workouts
      ################
      can :manage, Workout do |action, workout|
        workout  && (workout.user == user)
      end
      can :create, Workout
      can :index, Workout

      # Exercise_sessions
      ################
      can :manage, ExerciseSession do |action, exercise_session|
        exercise_session  && (exercise_session.workout_session.user == user)
      end
      can :create, ExerciseSession
      can :index, ExerciseSession

      # Exercises
      ################
      can :manage, Exercise do |action, exercise|
        exercise  && (exercise.user == user)
      end
      can :create, Exercise
      can :index, Exercise
      can :read, Exercise

      # Foodlogs
      ################
      can :manage, Foodlog do |action, foodlog|
        foodlog  && (foodlog.client_id == user.client_training_id)
      end
      can :create, Foodlog
      can :index, Foodlog

      #SUPERUSER
      ################
      if user.username == "jeremysenn"
        can :manage, :all
      end
    end
  end
end