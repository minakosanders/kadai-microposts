# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


```
_navbar.html.erb
リンクを追加
likes_user_path(current_page)
<li><%= link_to 'My Favorites', likes_user_path(current_user) %></li>

users/show.html.erb
<%#- クリックしたユーザーのmicropostsを追加 -%>
<%= render 'microposts', microposts: @user.microposts %>
or
<%= render 'microposts', microposts: user.microposts %>

users/likes.html.erb
<%#- ログインユーザーのmicropostsを追加 -%>
<%= render 'microposts', microposts: current_user.likes %>

microposts/_microposts.html.erb
like!、unlike!ボタンを追加
<%- microposts.each do |micropost| -%>
  <%= simple_format micropost.content %>
  <%- if current_user == @user or user -%>
    <%#- 参照しているユーザー情報がログインユーザーの場合 -%>
    <%= link_to "Destroy", micropost, method: :delete, data: { confirm: "削除しますがよろしいですか？" }, class: 'btn btn-danger' %>
  <%- else -%>
    <%#- 参照しているユーザー情報がログインユーザーではない場合 -%>
    <%- if current_user.favorites.find_by(micropost: micropost).blank? -%>
      <%#- お気に入りしているmicropostではない場合 -%>
      <%= form_for current_user.favorites.build do |f| %>
        <%= hidden_field_tag :micropost_id, micropost.id %>
        or
        <%= f.hidden_field :micropost_id, value: micropost.id %>
        <%= f.submit 'Follow', class: 'btn btn-primary' %>
      <%- end -%>
    <%- else -%>
      <%#- お気に入りしているmicropostの場合 -%>
      <%= link_to 'unlike!', micropost, method: delete, class: "btn btn-danger", data: { confirm: "お気に入りをやめますか？" } %>
    <%- end -%>
  <%- end -%>
<%- end -%>

favorites_controller.rb

def create
  @favorite = current_user.favorites.build(user: current_user, micropost_id: params[:micropost_id])
    or
  @favorite = current_user.favorites.build(favorite_params)
  if @favorite.save
    redirect_to ...
  else
    redirect_to ...
  end
end

private
  def favorite_params
    params.require(:favorite).permit(:user_id, :micropost_id)
  end
end
```
