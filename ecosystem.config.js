module.exports = {
  apps : [{
    name   : "fragments-app",
    script : "pnpm",
    args   : "start",
    env_production : {
      NODE_ENV: "production",
      PORT: 3000
    },
    instances: 1,
    watch: false,
  }]
};