pkgname=omen-fan-git
pkgver=r1.0000000
pkgrel=1
pkgdesc="Utility and daemon to control fans in HP Omen laptops"
arch=('any')
url="https://github.com/AksharLeo/omen-fan"
license=('GPL3')

depends=(
    'python'
    'python-click'
    'python-tomlkit'
    'python-click-aliases'
)

makedepends=('git')

backup=('etc/omen-fan/config.toml')
install=omen-fan.install

source=("git+$url.git")
sha256sums=('SKIP')

pkgver() {
    cd "$srcdir/omen-fan"
    printf "r%s.%s" \
        "$(git rev-list --count HEAD)" \
        "$(git rev-parse --short HEAD)"
}

package() {
    cd "$srcdir/omen-fan"

    install -Dm755 omen-fan.py "$pkgdir/usr/bin/omen-fan"
    install -Dm755 omen-fand.py "$pkgdir/usr/bin/omen-fand"

    install -Dm644 README.md \
        "$pkgdir/usr/share/doc/$pkgname/README.md"

    install -Dm644 /dev/stdin \
        "$pkgdir/etc/omen-fan/config.toml" <<'EOF'
[service]
TEMP_CURVE = [45, 55, 65, 75, 80, 85]
SPEED_CURVE = [30, 45, 65, 85, 95, 100]
IDLE_SPEED = 25
POLL_INTERVAL = 1.0

[script]
BYPASS_DEVICE_CHECK = 1
EOF

    install -Dm644 /dev/stdin \
        "$pkgdir/usr/lib/systemd/system/omen-fan.service" <<'EOF'
[Unit]
Description=HP Omen Fan Control Daemon
After=multi-user.target

[Service]
Type=simple
ExecStart=/usr/bin/omen-fand
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF
}
