defmodule Build do
  def run([full_version, base]) do
    {major, minor, _patch} = parse_version(full_version)
    version = "#{major}.#{minor}"

    build_dockerfile(version, base)

    {:ok, full_version_re} = Regex.compile("Elixir\s#{full_version}")

    if get_version_output(version, base) =~ full_version_re do
      IO.puts("Version testing #{IO.ANSI.green()}ok")
    else
      IO.puts("Version testing #{IO.ANSI.red()}failed")
    end
  end

  defp parse_version(full_version) do
    [major, minor, patch] = String.split(full_version, ".")

    {major, minor, patch}
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
