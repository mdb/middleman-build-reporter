# middleman-build-reporter

Fingerprint your Middleman build with a file reporting build-time detail.

## Output

middleman-build-reporter can output YAML and/or JSON:

The `build/build.yaml`:

```yaml
branch: master
revision: 244921c81c9e21a1973659df5f702937b91cfcd4
build_time: 2014-09-20 10:50:55 -0400
version: 1.2.3
```

The `build/build.json`:

```json
{
  "branch": "master",
  "revision": "244921c81c9e21a1973659df5f702937b91cfcd4",
  "build_time": "2014-09-20 10:50:55 -0400",
  "version": "1.2.3"
}
```

## Usage

In your `Gemfile`:

```ruby
gem 'middleman-build-reporter'
```

Install it:

```bash
$ bundle install
```

And configure it for basic usage within your `config.rb`:

```ruby
activate :middleman_build_reporter do
  # optional; the path to your project repository root
  # this must be absolute or relative from your build directory
  # defaults to app root
  build.repo_root = '../../../'

  # optional; the version of your app
  # defaults to ''
  build.version = '1.2.3'

  # optional; the build reporter file name
  # defaults to 'build'
  build.reporter_file = 'build'

  # optional; an array of desired build reporter file formats
  # supported formats: yaml, json
  # defaults to ['yaml']
  build.reporter_file = ['json', 'json']
end
```
