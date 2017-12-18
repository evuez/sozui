# SozUI

![I didn't call it "APrettyUIForSozu".](https://github.com/evuez/sozui/raw/master/screenshot.png)

An example interface for [Sōzu](https://github.com/sozu-proxy/sozu) using [ExSozu](https://github.com/evuez/exsozu).

The code lies in `SozUIWeb.SozuChannel` and `app.js` (though there's not much going on so it's like < 100 loc and not really interesting).

## Run

  * Install and start Sōzu.
  * Configure the socket path (it is set to `../sozu/bin/command_folder/sock` in `config/dev.exs`).
  * Install dependencies with `mix deps.get`.
  * Install Node.js dependencies with `cd assets && npm install`.
  * Start Phoenix endpoint with `mix phx.server`.

Go to [`localhost:4000`](http://localhost:4000).
