Push Notification Sample App using Private Pub
======

This application provides the user to register and sign in using authlogic. After login user can create a post and it will be visible on home page.

The home page will show the list of posts and will be subscribed to a channel.

When some other user creates his post then the post will be published to the specific channel and home page will be updated without refresh and new posts will be shown on home page via push notification using Private Pub gem.

You must start Faye to publish posts to the specific channel.

Steps to run the application after download.

$bundle install   # To install gems

$rails server     # To start Rails Server

$rackup private_pub.ru -s thin -E production    #To start Faye for subscribing and publishing to channels.

