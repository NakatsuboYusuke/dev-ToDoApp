<template>
  <v-card>
    <v-card-title>
      Todo List
      <v-spacer></v-spacer>
      <v-text-field v-model="search" append-icon="search" label="Search" single-line hide-details></v-text-field>
    </v-card-title>
    <v-data-table :headers="headers" :items="todos" :search="search">
      <template v-slot:item.action="{ item }">
        <v-icon small @click="deleteItem(item)">delete</v-icon>
      </template>
    </v-data-table>
  </v-card>
</template>

<script>
import axios from '~/plugins/axios'

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
      singleSelect: true,
      selected: [],
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
        },
        {
          text: 'Actions',
          value: 'action',
          sortable: false
        }
      ]
    }
  },
  computed: {
    user() {
      return this.$store.state.currentUser;
    }
  },
  // methods: {
  //   async deleteItem(item) {
  //     const res = confirm('本当に削除しますか？');
  //     if (res) {
  //       await axios.delete(`api/v1/todos/${item.id}`);
  //       const todos = this.user.todos.filter(todo => {
  //         return todo.id !== item.id;
  //       });
  //       const newUser = {
  //         ...this.user,
  //         todos
  //       };
  //       this.$store.commit('setUser', newUser);
  //     }
  //   }
  // }
}
</script>

<style scoped>
</style>