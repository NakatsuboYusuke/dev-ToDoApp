# README
This Repository is ToDoApp by Nuxt.js + Ruby on Rails API + Firebase<br>
<br>
Referenced by<br>
https://bit.ly/2FZf5xi

- Frontend Nuxt.js
- Backend Ruby on Rails API

## 環境
- Ruby 2.6.5
- Ruby on Rails API 5.2.3
- Node 12.0.0
- yarn 1.17.3
- Nuxt.js 2.11.00
- PostgreSQL 11.5

## 構成
:<snip>

## プロジェクトを生成

### Ruby on Rails APIをインストール

```
$ rails _5.2.3_ new backend --api -d postgresql
$ rails db:create

# => http://localhost:3000/
```

### Nuxt.jsをインストール

```
$ yarn create nuxt-app frontend

// ポート番号を変更する
# frontend/nuxt.config.js
export default {
  mode: 'spa',
  :<snip>
  server: {
    port: 8080, // デフォルト: 3000
  }
:<snip>
}

$ yarn run dev

# => http://localhost:8080/
```

## RailsでAPIを作成

### UserモデルとTodoモデルをscaffoldで作成

```
$ rails g scaffold User name:string email:string uid:string
$ rails db:migrate
$ rails g scaffold Todo title:string
$ rails db:migrate
$ rails g migration add_column_user_id
# => add_reference :todos, :user, foreign_key: true
$ rails db:migrate
```

### アソシエーションを作成

```
# backend/app/models/user.rb
:<snip>
has_many :todos, dependent: :destroy
:<snip>

# backend/app/models/todo.rb
:<snip>
belongs_to :user
:<snip>
```

### ルーティングを作成

```
# backend/config/routes.rb
:<:snip>
namespace :api, format: 'json' do
  namespace :v1 do
    resources :todos
    resources :users
  end
end
:<:snip>
```

### コントローラを修正

```
# backend/app/controllers/api/v1/users_controller.rb
module Api::V1
  class UsersController < ApplicationController
    :<snip>
  end
end

# backend/app/controllers/api/v1/todos_controller.rb
module Api::V1
  class TodosController < ApplicationController
    :<snip>
  end
end
```

## NuxtでComponentを作成
