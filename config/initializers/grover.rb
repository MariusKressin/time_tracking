Grover.configure do |config|
  config.options = {
    margin: {
      top: '1cm',
      bottom: '1cm'
    },
    launch_args: ['--font-render-hinting=medium'],
    wait_until: 'domcontentloaded'
  }
end
