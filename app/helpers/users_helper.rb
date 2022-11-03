module UsersHelper
  def gravatar_for(user, options = { size: 80 })
    size = options[:size]
    gravatar_id  = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=identicon"
    image_tag(gravatar_url, alt: user.username, class: 'gravatar')
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
end
