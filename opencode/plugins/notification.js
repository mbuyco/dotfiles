export const NotificationPlugin = async ({ project, client, $, directory, worktree }) => {
  return {
    event: async ({ event }) => {
      // Send notification on session completion
      if (event.type === "session.idle") {
        const soundFile = `${import.meta.dir}/notification-sound.mp3`

        if (process.platform === "darwin") {
          await $`osascript -e 'display notification "Work Complete!" with title "Opencode"'`
          await $`afplay ${soundFile}`.nothrow()
        } else if (process.platform === "linux" && Bun.which("notify-send")) {
          await $`notify-send "Opencode" "Work Complete!"`

          if (Bun.which("paplay")) {
            await $`paplay ${soundFile}`.nothrow()
          }
        }
      }
    },
  }
}
