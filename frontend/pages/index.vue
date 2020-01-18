<template>
  <div v-if="user">
    <!-- ログインしているユーザーを取得する -->
    <p>{{ user.name }}</p>
    <!-- 子コンポーネントから値を取得する -->
    <AddTodo @submit="addTodo" />
    <!-- 配列 todos に値をpushする -->
    <TodoList :todos="todos" />
  </div>
</template>

<script>
import AddTodo from '~/components/AddTodo';
import TodoList from '~/components/TodoList';

export default {
  components: {
    AddTodo,
    TodoList
  },
  computed: {
    user() {
      return this.$store.state.currentUser
    }
  },
  created() {
    // 環境変数が読み込めているか確認する
    // console.log('API_KEY:', process.env.API_KEY)
  },
  data() {
    return {
      todos: []
    }
  },
  methods: {
    addTodo(title) {
      this.todos.push({
        title
      });
    }
  }
}
</script>

<style scoped>
</style>
