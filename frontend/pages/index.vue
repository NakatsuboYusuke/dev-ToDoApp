<template>
  <div v-if="user">
    <!-- ログインしているユーザーを取得する -->
    <p>{{ user.name }}</p>
    <!-- 子コンポーネントから値を取得する -->
    <AddTodo @submit="addTodo" />
    <!-- 配列 todos に値をpushする --><!-- user_id を含める -->
    <TodoList :todos="user.todos" />
  </div>
</template>

<script>
import AddTodo from '~/components/AddTodo';
import TodoList from '~/components/TodoList';
import axios from '~/plugins/axios';

export default {
  components: {
    AddTodo,
    TodoList
  },
  // data() {
  //   return {
  //     //todos: []
  //   }
  // },
  computed: {
    user() {
      return this.$store.state.currentUser
    }
  },
  created() {
    // 環境変数が読み込めているか確認する
    // console.log('API_KEY:', process.env.API_KEY)
  },
  methods: {
    // 通信に user_id を含める
    async addTodo(todo) {
      const { data } = await axios.post('api/v1/todos', { todo })
      // ここでエラーが発生
      // this.$store.commit('setUser', {
      //   ...this.user,
      //   todos: [...this.user.todos, data]
      // })
    }
    // addTodo(title) {
    //   this.todos.push({
    //     title
    //   });
    // }
  }
}
</script>

<style scoped>
</style>
