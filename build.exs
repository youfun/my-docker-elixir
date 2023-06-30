defmodule Build do
  def run([version, base]) do
    build_dockerfile(version, base)

    {:ok, version_re} = Regex.compile("Elixir\s#{version}")

    if get_version_output(version, base) =~ version_re do
      IO.puts("Version testing #{IO.ANSI.green()}ok")
    else
      IO.puts("Version testing #{IO.ANSI.red()}failed")
    end
  end

  defp build_dockerfile(version, base) do
    System.cmd("docker", ["build", "-t", "local/elixir:#{version}-#{base}", "#{version}/#{base}"],
      into: IO.stream(:stdio, :line)
    )
  end

  defp get_version_output(version, base) do
    {output, 0} =
      System.cmd("docker", [
        "run",
        "--rm",
        "--entrypoint",
        "elixir",
        "local/elixir:#{version}-#{base}",
        "--version"
      ])

    output
  end
end

Build.run(System.argv())
