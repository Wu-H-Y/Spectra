import { useTranslation } from 'react-i18next'
import { Button } from '@/components/ui/button'
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card'

function App() {
  const { t } = useTranslation()

  return (
    <div className="min-h-screen bg-background">
      <header className="border-b">
        <div className="container mx-auto px-4 py-4 flex items-center justify-between">
          <h1 className="text-2xl font-bold">{t('appTitle')}</h1>
          <div className="flex gap-2">
            <Button variant="outline">{t('import')}</Button>
            <Button>{t('newRule')}</Button>
          </div>
        </div>
      </header>
      
      <main className="container mx-auto px-4 py-6">
        <div className="grid gap-6">
          <Card>
            <CardHeader>
              <CardTitle>{t('rules')}</CardTitle>
              <CardDescription>
                Manage your crawler rules for content extraction
              </CardDescription>
            </CardHeader>
            <CardContent>
              <p className="text-muted-foreground">
                No rules yet. Create your first rule to get started.
              </p>
            </CardContent>
          </Card>
        </div>
      </main>
    </div>
  )
}

export default App
