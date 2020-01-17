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
          username: '太郎'
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
      this.title = ''
    }
  }
}
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

## Nuxtでメソッドを追加

```
# frontend/pages/index.vue
<!-- 子コンポーネントから値を取得する -->
<AddTodo @submit="addTodo" />
<!-- 配列 todos に値をpushする -->
<TodoList :todos="todos" />

# frontend/components/TodoList.vue
:<snip>
export default {
  // 配列 todos の値を受け取る
  props: ['todos'],
  data() {
    return {
      // 初期値は不要となるので削除
      // todos: [
      //   {
      //     title: 'test',
      //     username: '太郎'
      //   }
      // ],
    :<snip>
    }
  }
}
</script>

# frontend/components/AddTodo.vue
export default {
  :<snip>
  methods: {
    handleSubmit() {
      // handleSubmit メソッドで取得した値を、$emit で親コンポーネントに渡す
      this.$emit('submit', this.title)
      this.title = ''
    }
  }
}
```

## Firebaseでプロジェクトを作成

### Authenticationのメール/パスワードを有効化

### ウェブアプリにFirebaseを追加

### Firebase CLIのインストール

```
$ npm install -g firebase-tools
```

### Firebaseのライブラリのインストール

```
$ npm install firebase
```

### dotenvのインストール

```
$ npm install --save-dev @nuxtjs/dotenv
```

### NuxtにFirebaseのプラグインを追加

```
# frontend/plugins/firebase.js
import firebase from "firebase/app"
import "firebase/auth"

const fbConfig = {
    apiKey: process.env.API_KEY,
    authDomain: process.env.AUTH_DOMAIN,
    databaseURL: process.env.DATABASE_URL,
    projectId: process.env.PROJECT_ID,
    storageBucket: process.env.STORAGE_BUCKET,
    messagingSenderId: process.env.MESSAGE_SENDER_ID,
    appId: process.env.APP_ID
};
firebase.initializeApp(fbConfig)

export default firebase


# frontend/nuxt.config.js
:<snip>
require('dotenv').config();
export default {
  :<snip>
  plugins: [
    '@/plugins/vuetify',
  ],
  :<snip>
}

```

### Firebaseの環境変数を保存する
マイアプリ => Firebase SDK snippet => 構成

```
$ touch .env

# frontend/.env
API_KEY="A****s"
AUTH_DOMAIN="d****m"
DATABASE_URL="h****m"
PROJECT_ID="d****p"
STORAGE_BUCKET="d****m"
MESSAGE_SENDER_ID="7****2"
APP_ID="1****5"

# frontend/.gitignore
.env

# frontend/pages/index.vue
export default {
  :<snip>
  created() {
    // 環境変数が読み込めているか確認する
    console.log('API_KEY:', process.env.API_KEY)
  },
  :<snip>
}
</script>

// => API_KEY: A****s
```

## Firebaseのログイン機能をNuxtに組み込む

### サインアップページを作成

```
# frontend/pages/signup.vue
<template>
  <v-row>
    <v-col cols="12" md="4">
      <h2>Sign Up</h2>
      <form>
        <v-text-field v-model="name" :counter="10" label="Name" data-vv-name="name" required></v-text-field>
        <v-text-field v-model="email" :counter="20" label="Email" data-vv-name="email" required></v-text-field>
        <v-text-field
          v-model="password"
          label="password"
          data-vv-name="password"
          required
          :type="show1 ? 'text' : 'password'"
          :append-icon="show1 ? 'mdi-eye' : 'mdi-eye-off'"
          @click:append="show1 = !show1"
        ></v-text-field>
        <v-text-field
          v-model="passwordConfirm"
          label="passwordConfirm"
          data-vv-name="passwordConfirm"
          required
          :type="show2 ? 'text' : 'password'"
          :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
          @click:append="show2 = !show2"
        ></v-text-field>
        <v-btn class="mr-4" @click="signup">submit</v-btn>
        <p v-if="error" class="errors">{{error}}</p>
      </form>
    </v-col>
  </v-row>
</template>

<script>
import firebase from '@/plugins/firebase'

export default {
  data() {
    return {
      email: '',
      name: '',
      password: '',
      passwordConfirm: '',
      show1: false,
      show2: false,
      error: ''
    };
  },
  methods: {
   signup() {
      if (this.password !== this.passwordConfirm) {
        this.error = '※パスワードとパスワード確認が一致していません'
      }
      firebase
        .auth()
        .createUserWithEmailAndPassword(this.email, this.password)
        .then(res => {
          console.log(res.user);
        })
        .catch(error => {
          this.error = (code => {
            switch (code) {
              case 'auth/email-already-in-use':
                return '既にそのメールアドレスは使われています'
              case 'auth/wrong-password':
                return '※パスワードが正しくありません'
              case 'auth/weak-password':
                return '※パスワードは最低6文字以上にしてください'
              default:
                return '※メールアドレスとパスワードをご確認ください'
            }
          })(error.code)
        })
    }
  }
}
</script>

<style scoped>
.errors {
  color: red;
  margin-top: 20px;
}
</style>
```

### Firebaseのコンソールでユーザーが登録できているか確認

### axiosの設定

```
$ npm install --save axios
```

```
# frontend/plugins/axios.js
import axios from 'axios'

export default axios.create({
    baseURL: process.env.API_ENDPOINT
})

// =>
// axios.post('http::/localhost:5000/api/v1/users', newUser)
// axios.post('/api/v1/users', newUser)

# frontend/.env
API_ENDPOINT="http://localhost:3000"
```

### サーバーを再起動する

```
$ yarn run dev
```

### サインアップページを編集

```
# frontend/pages/signup.vue
import axios from '@/plugins/axios'

export default {
  :<snip>
  methods: {
   signup() {
      if (this.password !== this.passwordConfirm) {
        this.error = '※パスワードとパスワード確認が一致していません'
      }
      firebase
        .auth()
        .createUserWithEmailAndPassword(this.email, this.password)
        .then(res => {
          const user = {
            email: res.user.email,
            name: this.name,
            uid: res.user.uid
          }
          axios.post('api/v1/users',{ user }).then(() => {
            this.$router.push("/")
          })
          //console.log(res.user)
        })
    }
  }
}

```

## Firebaseのログイン機能をRailsに組み込む

### CROSを許可

```
# backend/Gemfile
gem 'rack-cors'

$ bundle install

# backend/config/initializers/cors.rb
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
```

### ルーティングを整理

```
Rails.application.routes.draw do
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :todos, only: [:create, :destroy]
      resources :users, only: [:index, :create]
    end
  end
end
```

### userコントローラを整理

```
module Api::V1
  class UsersController < ApplicationController

    def index
      @users = User.all
      render json: @users
    end

    def create
      @user = User.new(user_params)

      if @user.save
        render json: @user, status: :created
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

  end
end
```

### Userモデルに値が追加されているか確認

```
$ rails c

# =>
Parameters: {"user"=>{"email"=>"testuser@test.com", "name"=>"testUser", "uid"=>"lhHxsWlR1MVeCehE7Hf66X0q9Uh1"}}
```

## セッションの保持

### Firebaseでログインしているユーザーを呼び出す

```
# frontend/plugins/auth-check.js
import firebase from '@/plugins/firebase'
import axios from '@/plugins/axios'

const authCheck = ({ store, redirect }) => {
    firebase.auth().onAuthStateChanged(async user => {
        if (user) {
            const { data } = await axios.get(`/v1/users?uid=${user.uid}`)
            console.log('ログインしているユーザー:', data)
        }
    })
}

export default authCheck

# frontend/nuxt.config.js
export default {
  :<snip>
  plugins: [
    '@/plugins/vuetify',
    '@/plugins/auth-check'
  ],
  :<snip>
}
```

### ブラウザのコンソールでユーザーが呼び出されているか確認

```
$ yarn run dev

// => ログインしているユーザー: (2) [{…}, {…}]
```

### Railsでログインしているユーザーの検索

```
# backend/app/controllers/api/v1/users_controller.rb
def index
  if params[:uid]
    @user = User.find_by(uid: params[:uid])
    render json: @user
  else
    @users = User.all
    render json: @users
  end
end
```

### ブラウザのコンソールでユーザーが呼び出されているか再度確認

```
# =>
ログインしているユーザー: {id: 1, name: "testUser1", email: "testuser1@test.com", uid: "fMwwF9Jh1Kdw5ME70OwIUDvU3it1", created_at: "2020-01-17T10:52:08.331Z", …}
```
