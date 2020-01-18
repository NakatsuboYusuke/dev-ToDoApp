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
  computed: {
    user() {
      return this.$store.state.currentUser
    }
  },
  methods: {
    handleSubmit() {
      // user_id も含めたオブジェクトを作る
      const todo = {
        title: this.title,
        user_id: this.user.id
      }
      // handleSubmit メソッドで取得した値を、$emit で親コンポーネントに渡す
      this.$emit('submit', todo)
      this.title = ''
    }
  }
}
</script>

<style scoped>
</style>
