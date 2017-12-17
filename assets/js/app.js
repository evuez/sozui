import socket from "./socket"

let commands = document.querySelectorAll("button[data-command]")
for (var i = 0; i < commands.length; i++) {
    commands[i].addEventListener("click", command)
}

let main = document.querySelector("main")

let channel = socket.channel("sozu:lobby", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

channel.on("answer", answer => {
  console.log(`Answer: ${JSON.stringify(answer)}`)

  switch (window.location.hash) {
    case '#workers':
      main.innerText += `[${answer.status}] ${displayWorkers(answer)}\n`
      break
    case '#dump-state':
      main.innerText += `[${answer.status}] ${displayDumpState(answer)}\n`
      break
    default:
      main.innerText += `[${answer.status}] ${answer.message}\n`
  }
})

function command() {
  let {command} = this.dataset

  channel.push(`command:${command}`, {})
    .receive("ok", _ => {
      window.location.hash = command
      main.innerText = ''
    })
    .receive("timeout", _ => { main.innerText = "Couldn't connect to Sōzu :/\n" })
}

function displayWorkers(answer) {
  return '\n' + answer.data.data.reduce((acc, value) => {
    return `${acc}\n${value.id} | ${value.run_state} | ${value.pid}`
  }, "")
}
function displayDumpState(answer) {
  return JSON.stringify(answer.data.data)
}
