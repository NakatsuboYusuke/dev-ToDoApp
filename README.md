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

```
# frontend/pages/index.vue
<template>
  <div>
    <AddTodo />
    <TodoList />
  </div>
</template>

<script>
import AddTodo from "~/components/AddTodo";
import TodoList from "~/components/TodoList";

export default {
  components: {
    AddTodo,
    TodoList
  },
  data() {
    return {
      todos: []
    }
  }
}
</script>

<style>
</style>


# frontend/components/TodoList.vue
<template>
  <v-card>
    <v-card-title>
      Todo List
      <v-spacer></v-spacer>
      <v-text-field v-model="search" append-icon="search" label="Search" single-line hide-details></v-text-field>
    </v-card-title>
    <v-data-table :headers="headers" :items="todos" :search="search"></v-data-table>
  </v-card>
</template>

<script>
export default {
  data() {
    return {
      todos: [
        {
          title: 'test',
          username: '太郎',
        }
      ],
      search: '',
      headers: [
        {
          text: 'タイトル',
          align: 'left',
          sortable: false,
          value: 'title'
        },
        {
          text: 'ユーザー名',
          value: 'username'
        }
      ]
    }
  }
}
</script>

<style>
</style>


# frontend/components/AddTodo.vue
<template>
  <v-form>
    <v-container>
      <v-row>
        <v-col cols="12" md="4">
          <v-text-field v-model="title" :counter="10" label="todo" required></v-text-field>
        </v-col>
        <v-col cols="12" md="4">
          <v-btn @click="handleSubmit">作成</v-btn>
        </v-col>
      </v-row>
    </v-container>
  </v-form>
</template>

<script>
export default {
  data() {
    return {
      title: ''
    };
  },
  methods: {
    handleSubmit() {
      this.title = '';
    }
  }
};
</script>

<style>
</style>
```

### プラグインを追加

```
$ npm install material-design-icons-iconfont

# frontend/plugins/vuetify.js
import 'material-design-icons-iconfont/dist/material-design-icons.css'
import Vue from 'vue'
import Vuetify from 'vuetify/lib'

Vue.use(Vuetify)

export default new Vuetify({
  icons: {
    iconfont: 'md',
  }
})

# frontend/nuxt.config.js
export default {
  :<snip>
  plugins: [
    '@/plugins/vuetify',
  ],
  :<snip>
}
```
