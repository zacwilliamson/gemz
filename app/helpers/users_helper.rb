module UsersHelper
  def profile_img(user)
    if user.profile.image.attached?
      url_for(user.profile.image)
    else
      gravatar_url(user)
    end
  end

  def gravatar_for(user, options = { size: 80 })
    size = options[:size]
    gravatar_id  = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=retro"
    image_tag(gravatar_url, alt: user.username, class: 'gravatar')
  end

  def gravatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=250&d=retro"
  end

  def add_friend_btn(current_user, user)
    if current_user.recived_request?(user)
      'Accept'
    else
      'Add friend'
    end
  end

  def unfriend_btn(current_user, user)
    if current_user.recived_request?(user)
      'Decline'
    elsif current_user.pending_friends.include?(user)
      'Request sent'
    else
      'Unfriend'
    end
  end

  # notification methods

  def post_link(notification)
    if notification.notifiable_type == 'Reaction'
      notification.notifiable.reactable
    elsif notification.notifiable_type == 'Comment'
      notification.notifiable.post
    end
  end

  def notification_content(notification)
    if notification.notifiable_type == 'Reaction'
      notification.notifiable.reactable.content.truncate(70)
    elsif notification.notifiable_type == 'Comment'
      notification.notifiable.content.truncate(70)
    end
  end

  def notification_icon
    {
      Friendship: {
        icon: 'people',
        class: 'text-blue-500'
      },
      Reaction: {
        icon: 'heart',
        class: 'text-rose-500'
      },
      Comment: {
        icon: 'chatbubbles',
        class: 'text-green-500'
      }
    }
  end
end
