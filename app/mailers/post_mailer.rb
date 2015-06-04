class PostMailer < ActionMailer::Base

  def post_created(user)
    mail(to: user.email,
          from: "service@gmail.com",
          subject: "Post Created",
          body: "this is my first Mail"
    )
  end
end