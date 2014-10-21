[![Build Status](https://travis-ci.org/mdb/middleman-build-reporter.svg?branch=master)](https://travis-ci.org/mdb/middleman-build-reporter)

# middleman-build-reporter

middleman-build-reporter helps you understand what code has been deployed to an environment, and whether you're viewing cached or stale build artifacts.

Features:

1. Generate YAML and/or JSON files reporting build-time/version details for your [Middleman](http://middlemanapp.com) app.
2. Fingerprint each Middleman HTML template with a `<!-- FINGERPRINT -->` comment surfacing build-time/version details.

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

middleman-build-reporter also offers a `build_reporter_fingerprint` helper to fingerprint HTML templates:

```html
<!--
FINGERPRINT:
---
branch: master
revision: c786c0addcde128a0823c40ebb4a3ab453411f10
build_time: '2014-10-21 07:27:51 -0400'
version: 1.2.3
--!>
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

## Fingerprinting you HTML templates

Use the `build_reporter_fingerprint` to fingerprint your HTML templates with build/version details:

Example usage in `layouts/layout.erb`:

```html
<body>
  <h1>Some Site</h1>
</body>

<%= build_reporter_fingerprint %>
```

Example fingerprint HTML comment:

```html
<body>
  <h1>Some Site</h1>
</body>

<!--
FINGERPRINT:
---
branch: master
revision: c786c0addcde128a0823c40ebb4a3ab453411f10
build_time: '2014-10-21 07:27:51 -0400'
version: 1.2.3
--!>
```

## Reporting additional custom build details

Add any additional build details to a `.build_reporter.yml` file in your project's root.

The `.build_reporter.yml` can be produced as part of your app's build process, or manually managed.

### Example - custom extended details:

The `.build_reporter.yml`:

```
---
foo: 'bar'
baz: 'bim'
```

The output `build/build.yaml`:

```
branch: master
revision: 244921c81c9e21a1973659df5f702937b91cfcd4
build_time: 2014-09-20 10:50:55 -0400
version: 1.2.3
foo: bar
baz: bim
```

### Example - using .build_reporter.yml to override built-in middleman-build-reporter details:

The `.build_reporter.yml` file can also override the values set by `Middleman::BuildReporter::Reporter`.

The `.build_reporter.yml`:

```
---
revision: 'some_revision'
build_time: 'some_other_time'
```

The output `build/build.yaml`:

```
branch: master
revision: some_revision
build_time: some_other_time
version: 1.2.3
```
