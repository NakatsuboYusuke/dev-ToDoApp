<template>
  <div>
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

<style>
</style>
