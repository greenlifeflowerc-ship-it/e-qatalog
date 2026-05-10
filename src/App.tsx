import './App.css'

function App() {
  return (
    <main className="min-h-screen bg-black text-white">
      <section
        style={{
          minHeight: '100vh',
          background:
            'radial-gradient(circle at center, rgba(214,170,50,0.18), transparent 35%), #050505',
          color: '#F7EFE0',
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          textAlign: 'center',
          padding: '40px',
        }}
      >
        <div>
          <h1
            style={{
              fontSize: 'clamp(42px, 7vw, 96px)',
              lineHeight: 1.05,
              marginBottom: '24px',
              color: '#D6AA32',
            }}
          >
            Flower Center Catalog
          </h1>

          <p
            style={{
              fontSize: 'clamp(18px, 2vw, 28px)',
              color: '#B9A987',
              maxWidth: '760px',
              margin: '0 auto 32px',
            }}
          >
            Premium artificial trees catalog is ready.
          </p>

          <div
            style={{
              display: 'inline-block',
              border: '1px solid rgba(214,170,50,0.45)',
              borderRadius: '999px',
              padding: '14px 28px',
              color: '#F2D27A',
              background: 'rgba(255,255,255,0.04)',
            }}
          >
            Build fixed successfully
          </div>
        </div>
      </section>
    </main>
  )
}

export default App
