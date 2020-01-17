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