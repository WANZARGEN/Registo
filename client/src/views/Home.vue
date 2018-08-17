<template>
  <div class="wrapper">
    <Mapping/>
  </div>
</template>

<script>
import Uploader from '@/components/Uploader.vue'
import Mapper from '@/components/Mapper.vue'

export default {
  name: 'Home',
  components: { Uploader, Mapper }
}
</script>

<style lang="scss" scoped>
@import "@/styles/variables.scss";
</style>
