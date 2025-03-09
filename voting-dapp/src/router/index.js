import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'mandate',
      component: () => import('../views/MandateView.vue'),
    },
    {
      path: '/board',
      name: 'board',
      component: () => import('../views/BoardView.vue'),
    },
    {
      path: '/account',
      name: 'account',
      component: () => import('../views/AccountView.vue'),
    },
  ],
})

export default router
