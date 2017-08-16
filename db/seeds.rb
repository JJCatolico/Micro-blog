u = User.create(username: "JJ", password: "password")

u.posts.create(text: "My first post")
u.posts.create(text: "My second post")
u.posts.create(text: "My third post")
u.posts.create(text: "My fourth post")