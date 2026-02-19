// API types matching the Dart models

export type MediaType = 'video' | 'music' | 'novel' | 'comic' | 'image' | 'audio' | 'rss' | 'generic'

export type SelectorType = 'css' | 'xpath' | 'regex' | 'jsonpath' | 'js'

export interface Selector {
  type: SelectorType
  expression: string
  attribute?: string
  fallbacks?: Selector[]
  firstOnly?: boolean
}

export interface Transform {
  type: string
  params?: unknown
}

export interface FieldMapping {
  field: string
  selector: Selector
  defaultValue?: string
  transforms?: Transform[]
  required?: boolean
}

export interface PaginationConfig {
  type: 'url' | 'click' | 'infiniteScroll'
  nextSelector?: Selector
  urlTemplate?: string
  clickSelector?: Selector
  scrollContainer?: Selector
  maxPages?: number
  delayMs?: number
  waitAfterLoadMs?: number
}

export interface ListExtract {
  container: Selector
  items: FieldMapping[]
  pagination?: PaginationConfig
  url?: string
}

export interface DetailExtract {
  urlFromList?: Selector
  items: FieldMapping[]
  chapters?: ChapterExtract
}

export interface ChapterExtract {
  container: Selector
  items: FieldMapping[]
  reverseOrder?: boolean
}

export interface ContentExtract {
  video?: VideoExtract
  comic?: ComicExtract
  novel?: NovelExtract
  music?: MusicExtract
}

export interface VideoExtract {
  playUrl?: Selector
  qualities?: Selector
  jsExtract?: string
}

export interface ComicExtract {
  images: Selector
  jsExtract?: string
}

export interface NovelExtract {
  content: Selector
  jsExtract?: string
}

export interface MusicExtract {
  audioUrl?: Selector
  lyrics?: Selector
  jsExtract?: string
}

export interface ExtractConfig {
  list?: ListExtract
  detail?: DetailExtract
  content?: ContentExtract
}

export interface MatchConfig {
  pattern: string
  type: 'regex' | 'glob'
  fullUrl?: boolean
  includePatterns?: string[]
  excludePatterns?: string[]
}

export interface RequestConfig {
  method?: string
  headers?: Record<string, string>
  body?: string
  query?: Record<string, string>
  cookies?: Record<string, string>
  timeoutMs?: number
  followRedirects?: boolean
  maxRedirects?: number
  userAgent?: string
  mobileUserAgent?: boolean
  referer?: string
}

export type ActionType = 'wait' | 'click' | 'scroll' | 'fill' | 'script' | 'condition' | 'loop'

export interface CrawlerAction {
  type: ActionType
  params: Record<string, unknown>
}

export interface DetectionConfig {
  captcha?: CaptchaDetection
  rateLimit?: RateLimitDetection
  login?: LoginDetection
  detectCloudflare?: boolean
  autoRetry?: boolean
  maxRetries?: number
}

export interface CaptchaDetection {
  detectRecaptcha?: boolean
  detectHcaptcha?: boolean
  detectGeneric?: boolean
  solverApiKey?: string
  solverService?: string
}

export interface RateLimitDetection {
  statusCodes?: number[]
  textPatterns?: string[]
  minDelayMs?: number
  maxDelayMs?: number
  exponentialBackoff?: boolean
}

export interface LoginDetection {
  detectLoginPage?: boolean
  loginSelectors?: string[]
  pauseOnLogin?: boolean
}

export interface CrawlerRule {
  id: string
  name: string
  description?: string
  mediaType: MediaType
  version?: string
  match: MatchConfig
  request?: RequestConfig
  extract: ExtractConfig
  beforeActions?: CrawlerAction[]
  afterActions?: CrawlerAction[]
  detection?: DetectionConfig
  author?: string
  source?: string
  iconUrl?: string
  tags?: string[]
  enabled?: boolean
  createdAt?: string
  updatedAt?: string
}

export interface ServerStatus {
  isRunning: boolean
  port: number
  url: string
}

export interface ValidationResult {
  valid: boolean
  errors: ValidationError[]
}

export interface ValidationError {
  path: string
  message: string
}

export interface ExecutionResult {
  success: boolean
  data?: unknown
  error?: string
  extractedCount: number
}
