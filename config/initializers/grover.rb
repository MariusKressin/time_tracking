Grover.configure do |config|
  config.options = {
    format: 'A4',
    margin: {
      top: '5px',
      bottom: '10cm'
    },
    user_agent: 'Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0',
    viewport: {
      width: 640,
      height: 480
    },
    prefer_css_page_size: true,
    emulate_media: 'screen',
    bypass_csp: true,
    media_features: [{ name: 'prefers-color-scheme', value: 'dark' }],
    timezone: 'Australia/Sydney',
    extra_http_headers: { 'Accept-Language': 'en-US' },
    geolocation: { latitude: 59.95, longitude: 30.31667 },
    cache: false,
    launch_args: ['--font-render-hinting=medium'],
    wait_until: 'domcontentloaded'
  }
end
