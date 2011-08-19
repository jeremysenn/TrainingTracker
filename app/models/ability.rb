class Ability
  include CanCan::Ability

  # note: abilities defined later have higher priority
  def initialize(user)
    if not user
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
    elsif user # user, non-admin
#      can :manage, :all

      # Biosignatures
      ################
      can :manage, Biosignature do |action, biosignature|
        biosignature  && (biosignature.client.user == user)
      end
      can :create, Biosignature
      can :index, Biosignature

      # Clients
      ################
      can :manage, Client do |action, client|
        client  && (client.user == user)
      end
      can :create, Client
      can :index, Client

      # Workout_sessions
      ################
      can :manage, WorkoutSession do |action, workout_session|
        workout_session  && (workout_session.user == user)
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
        exercise_session  && (exercise_session.user == user)
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

    end
  end
end