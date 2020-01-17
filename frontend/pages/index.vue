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
