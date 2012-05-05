require 'sendgrid'
class SupportMailer < ActionMailer::Base
  default_url_options[:host] = HOST_FOR_URL

  def new_account_notification(user)
    subject       "New Tracker Account"
    from          "Senn Performance"
    @from =       "info@sennperformance.com"
    recipients    user.email + ", info@sennperformance.com"
    sent_on       Time.now
    body          :user => user
  end

  def new_bodycomp_notification(client)
    subject       "Body Composition Assessment"
    from          "Senn Performance"
    @from =       "info@sennperformance.com"
    recipients    client.email + ", info@sennperformance.com"
    sent_on       Time.now
    body          :client => client
  end

  def password_reset(user)
    subject       "Password Reset"
    from          "Tracker"
    @from =       "info@sennperformance.com"
    @user =       user
    recipients    user.email
    body          :to => user.email
  end

  def new_trainer_notification(trainer)
    subject       "New Trainer Created"
    from          "Pro Fitness Success"
    @from =       "info@profitnesssuccess.com"
    recipients    trainer.email + ", info@profitnesssuccess.com"
    sent_on       Time.now
    body          :trainer => trainer, :url => "http://68.185.20.83:3003/signup?group_id=5"
  end

#  def password_reset_instructions(user)
#    subject       "FairCare password reset request"
#    from          "FairCare Support"
#    @from =       "support@faircaremd.com"
#    recipients    user.email
#    sent_on       Time.now
#    body          :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
#  end
#
#  def account_confirmation(user)
#    subject       "FairCare account confirmation request"
#    from          "FairCare Support"
#    @from =       "support@faircaremd.com"
#    recipients    user.email
#    sent_on       Time.now
#    body          :edit_account_confirmation_url => edit_account_confirmation_url(user.perishable_token)
#  end
#
#  def admin_new_account_notification(user)
#    subject       "New account confirmation [#{Rails.env}]"
#    from          "FairCare Support"
#    @from =       "support@faircaremd.com"
#    recipients    "admin@faircaremd.com"
#    sent_on       Time.now
#    body          :user => user
#  end
#
#  def signup_with_invalid_code_notfication(user)
#    subject       "New account confirmation with invalid activation code [#{Rails.env}]"
#    from          "FairCare Support"
#    @from =       "support@faircaremd.com"
#    recipients    "providers@faircaremd.com"
#    sent_on       Time.now
#    body          :user => user
#  end
#
#  def done_deal_notification(done_deal_request, recipient)
#    subject       "Congratulations!  You got what you wanted!"
#    from          "FairCare Support"
#    @from =       "donedeal@faircaremd.com"
#    recipients    recipient + ", requests@faircaremd.com"
#    sent_on       Time.now
#    body          :done_deal_request => done_deal_request
#  end
#
#  def custom_deal_notification(custom_deal_request, recipient)
#    subject       "Your FairCareMD Request ##{custom_deal_request.id} has been created"
#    from          "FairCare Support"
#    @from =       "requests@faircaremd.com"
#    recipients    recipient + ", requests@faircaremd.com"
#    sent_on       Time.now
#    body          :custom_deal_request => custom_deal_request
#  end
#
#  def new_deal_description_pending_notification(new_deal_request, recipient)
#    subject       "YourFairCareMD Request ##{new_deal_request.id} Pending Provider Review"
#    from          "FairCare Support"
#    @from =       "requests@faircaremd.com "
#    recipients    recipient + ", requests@faircaremd.com"
#    sent_on       Time.now
#    body          :new_deal_request => new_deal_request
#  end
#
#  def new_deal_counter_notification(new_deal_request, recipient, patient = nil)
#    subject       "You have a counter-offer in response to your request on FairCareMD"
#    from          "FairCare Support"
#    @from =       "requests@faircaremd.com "
#    recipients    recipient + ", requests@faircaremd.com"
#    sent_on       Time.now
#    if patient
#      body          :is_patient => (!patient.nil?), :new_deal_request => new_deal_request, :dashboard_url => done_deal_dashboard_patient_url(patient)
#    else
#      body          :is_patient => (!patient.nil?), :new_deal_request => new_deal_request, :register_url => register_patient_url
#    end
#  end
#
#  def new_deal_price_pending_notification(new_deal_request, recipient)
#    subject       "YourFairCareMD Request ##{new_deal_request.id} Pending Provider Review"
#    from          "FairCare Support"
#    @from =       "requests@faircaremd.com "
#    recipients    recipient + ", requests@faircaremd.com"
#    sent_on       Time.now
#    body          :new_deal_request => new_deal_request
#  end
#
#  def provider_new_deal_request_notification(new_deal_request, recipient)
#    subject       "You have a Care Request to review on FairCareMD"
#    from          "FairCare Support"
#    @from =       "requests@faircaremd.com "
#    recipients    recipient + ", requests@faircaremd.com"
#    sent_on       Time.now
#    body          :new_deal_request => new_deal_request,
#                  :dashboard_url =>
#                    done_deal_dashboard_practice_provider_url(
#                      new_deal_request.offer.provider.practice,
#                      new_deal_request.offer.provider)
#  end
#
#  def provider_done_deal_request_notification(new_deal_request, recipient)
#    subject       "You have a done deal request that needs scheduling on FairCareMD"
#    from          "FairCare Support"
#    @from =       "requests@faircaremd.com "
#    recipients    recipient + ", requests@faircaremd.com"
#    sent_on       Time.now
#    body          :new_deal_request => new_deal_request,
#                  :dashboard_url =>
#                    done_deal_dashboard_practice_provider_url(
#                      new_deal_request.offer.provider.practice,
#                      new_deal_request.offer.provider)
#  end
#
#
#  def new_deal_reject_notification(new_deal_request, recipient)
#    subject       "YourFairCareMD Request ##{new_deal_request.id} Rejected - Too Low"
#    from          "FairCare Support"
#    @from =       "requests@faircaremd.com "
#    recipients    recipient + ", requests@faircaremd.com"
#    sent_on       Time.now
#    body          :new_deal_request => new_deal_request
#  end
#
#  def new_deal_reject_generic_notification(new_deal_request, recipient)
#    subject       "YourFairCareMD Request ##{new_deal_request.id} has been rejected"
#    from          "FairCare Support"
#    @from =       "requests@faircaremd.com "
#    recipients    recipient + ", requests@faircaremd.com"
#    sent_on       Time.now
#    body          :new_deal_request => new_deal_request
#  end
#
#  def review_notification(done_deal_request, recipient)
#    subject       "Time to submit a Review"
#    from          "FairCare Support"
#    @from =       "reviews@faircaremd.com"
#    recipients    recipient
#    sent_on       Time.now
#    body          :done_deal_request => done_deal_request, :sign_in_url => login_url
#  end
#
#  def completed_review_notification(review, recipient)
#    subject       "A patient Review of your completed service has been submitted."
#    from          "FairCare Support"
#    @from =       "reviews@faircaremd.com"
#    recipients    recipient
#    sent_on       Time.now
#    body          :review => review, :sign_in_url => login_url
#  end
#
#  def verified_review_notification(review, recipient)
#    subject       "Provider has verified your visit and your Review is now public."
#    from          "FairCare Support"
#    @from =       "reviews@faircaremd.com"
#    recipients    recipient
#    sent_on       Time.now
#    body          :review => review, :sign_in_url => login_url
#  end
#
#  def review_comments_approved_notification(review, recipient)
#    subject       "Provider has approved your Review Comments and they are now public."
#    from          "FairCare Support"
#    @from =       "reviews@faircaremd.com"
#    recipients    recipient
#    sent_on       Time.now
#    body          :review => review, :sign_in_url => login_url
#  end
#
#  def patient_survey_notification(survey)
#    subject       "New patient survey submitted to FairCareMD."
#    from          "FairCare Support"
#    @from =       "support@faircaremd.com"
#    recipients    "providers@faircaremd.com"
#    sent_on       Time.now
#    body          :survey => survey
#  end
#
#  def deploy_notification(attribs)
#    subject       "A build of faircare was deployed to #{attribs[:env_name]}"
#    from          "FairCare CodeMonkey HQ"
#    @from =       "support@faircaremd.com"
#    recipients    "madcowley@gmail.com, mike.pence@gmail.com"
#    sent_on       Time.now
#    body          :revision => attribs[:revision], :env_name => attribs[:env_name]
#  end
#
#  def test_message(addr)
#    subject "test me"
#    from "faircare"
#    recipients addr
#    sendgrid_recipients = [addr]
#  end
#
#  def new_recommend_doc_notification(recommend_doc)
#    subject       "New Recommend a Doc"
#    from          "FairCare Sales"
#    @from =       "sales@faircaremd.com"
#    recipients    "sales@faircaremd.com"
#    sent_on       Time.now
#    body          :recommend_doc => recommend_doc
#  end
#
#  def new_join_movement_notification(join_movement)
#    subject       "New Join the Movement"
#    from          "FairCare Sales"
#    @from =       "sales@faircaremd.com"
#    recipients    "sales@faircaremd.com"
#    sent_on       Time.now
#    body          :join_movement => join_movement
#  end
#
#  def new_advertiser_notification(advertiser)
#    subject       "New Advertiser"
#    from          "FairCare Sales"
#    @from =       "sales@faircaremd.com"
#    recipients    "advertisers@faircaremd.com"
#    sent_on       Time.now
#    body          :advertiser => advertiser
#  end
end