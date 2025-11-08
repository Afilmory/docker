import { defineBuilderConfig } from '@afilmory/builder'

export default defineBuilderConfig(() => ({
  repo: {
    // Use remote repository as manifest and thumbnail cache
    enable: false,
    url: 'https://github.com/username/gallery-public',
  },
  storage: {
    // Storage configuration
    provider: 's3',
    bucket: 'your-photos-bucket',
    endpoint: 'your-s3-endpoint',
    region: 'us-east-1',
    prefix: 'photos/',
    customDomain: 'cdn.yourdomain.com',
  },
}))
