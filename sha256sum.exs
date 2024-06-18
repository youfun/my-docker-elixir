#!/usr/bin/env elixir

defmodule Sha256Sum do
  alias IO.ANSI

  def run([version]) do
    Mix.install([:req])

    %{body: body} =
      Req.get!("https://github.com/elixir-lang/elixir/archive/v#{version}.tar.gz")

    hash = :crypto.hash(:sha256, body)

    hash
    |> Base.encode16(case: :lower)
    |> puts_hash()

    File.write!("elixir-#{version}.tar.gz", body)
  end

  def puts_hash(hex) do
    IO.puts("sha256: " <> ANSI.green() <> hex <> ANSI.reset())
  end
end

Sha256Sum.run(System.argv())
