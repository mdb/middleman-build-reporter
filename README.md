[![Build Status](https://travis-ci.org/mdb/middleman-build-reporter.svg?branch=master)](https://travis-ci.org/mdb/middleman-build-reporter)

# middleman-build-reporter

Fingerprint your [Middleman](http://middlemanapp.com) build with YAML and/or JSON files reporting build-time details.

middleman-build-reporter helps you understand what code has been deployed to an environment.

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

Activate it within your `config.rb`:

```
activate :build_reporter
```

Supported configuration

```ruby
activate :build_reporter do |build|
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
  build.reporter_file_formats = ['yaml', 'json']
end
```

## Reporting additional custom build details

Add any additional build details to a `.build_reporter.yml` file in your project's root.

The `.build_reporter.yml` can be produced as part of your app's build process, or manually managed.

### Example - custom extended details:

The `.build_reporter.yml`:

```
---
foo: 'bar'
```

The output `build/build.yaml`:

```
branch: master
revision: 244921c81c9e21a1973659df5f702937b91cfcd4
build_time: 2014-09-20 10:50:55 -0400
version: 1.2.3
foo: bar
```

### Example - using .build_reporter.yml to override built-in middleman-build-reporter details:

The `.build_reporter.yml`:

```
---
revision: 'some_revision'
```

The output `build/build.yaml`:

```
branch: master
revision: some_revision
build_time: 2014-09-20 10:50:55 -0400
version: 1.2.3
```
