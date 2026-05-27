import os

def replace_in_file(filepath, replacements):
    with open(filepath, 'r') as f:
        content = f.read()
    
    for old, new in replacements:
        content = content.replace(old, new)
        
    with open(filepath, 'w') as f:
        f.write(content)

# 1. Styles
replace_in_file('lib/constants/styles.dart', [
    ('Color(0xFF0A0612)', 'Color(0xFFF6F8FD)'),
    ('Color(0xFF1D1B26)', 'Color(0xFFFFFFFF)'),
])

# 2. Text colors globally (turn white back to black87 for text)
text_files = [
    'lib/screens/widgets/header_text_widget.dart',
    'lib/screens/widgets/mobile_widgets/header_text_mobile.dart',
    'lib/screens/widgets/download_cv_widget.dart',
    'lib/screens/largescreen/desktop_layout_page.dart',
    'lib/screens/tablet/tablet_layout_page.dart',
    'lib/screens/mobile/mobile_layout_page.dart',
    'lib/screens/widgets/animated_about_section.dart',
    'lib/screens/widgets/mobile_widgets/about_section_mobile.dart'
]
for file in text_files:
    if os.path.exists(file):
        replace_in_file(file, [
            ('color: Colors.white70', 'color: Colors.black87'),
            ('color: Colors.white54', 'color: Colors.black54'),
            ('color: Colors.white,', 'color: Colors.black87,'),
            ('color: Colors.white)', 'color: Colors.black87)'),
        ])

# Fix AppBar to be dark so white menus look good (user asked for white menus)
for file in ['lib/screens/largescreen/desktop_layout_page.dart']:
    replace_in_file(file, [
        ('backgroundColor: isScrolledPastHome ? const Color(0xFF0A0612).withOpacity(0.9) : Colors.transparent,', 'backgroundColor: Color(0xFF1E1E2C),'),
        ('color: Colors.black87, fontWeight: FontWeight.w500', 'color: Colors.white, fontWeight: FontWeight.w500'), # Make menus white
    ])

# 3. Project Cards
project_files = [
    'lib/screens/widgets/project_tile_card.dart',
    'lib/screens/widgets/mobile_widgets/project_section_mobile.dart',
    'lib/screens/widgets/tab_widgets/project_section_tab.dart',
]
for file in project_files:
    if os.path.exists(file):
        replace_in_file(file, [
            ('Color(0xFF1A1A24)', 'Color(0xFFFFFFFF)'),
            ('Color(0xFF222230)', 'Color(0xFFF8F9FA)'),
            ('Color(0xFF12121A)', 'Color(0xFFFFFFFF)'),
            ('Colors.blueAccent.withOpacity(0.08)', 'Colors.black.withOpacity(0.04)'),
            ('Colors.white', 'Colors.black87'),
        ])

# 4. Skills Cards
skills_files = [
    'lib/screens/widgets/skills_section.dart',
    'lib/screens/widgets/mobile_widgets/skills_mobile.dart',
    'lib/screens/widgets/tab_widgets/skills_tab_widget.dart',
]
for file in skills_files:
    if os.path.exists(file):
        replace_in_file(file, [
            ('Color(0xFF1E1E2C)', 'Color(0xFFFAFAFA)'),
            ('Color(0xFF12121A)', 'Color(0xFFFFFFFF)'),
            ('Colors.blueAccent.withOpacity(0.5)', 'Colors.black.withOpacity(0.05)'),
            ('Colors.white10', 'Colors.black.withOpacity(0.05)'),
            ('Colors.blueAccent.withOpacity(0.2)', 'Colors.black.withOpacity(0.05)'),
            ('Colors.white70', 'Colors.black87'),
            ('Colors.white54', 'Colors.black54'),
            ('Colors.white', 'Colors.black87'),
            ('Colors.blueAccent', 'Color(0xFF2962FF)'), # A nice premium blue for hover
        ])

print("Theme changed to minimalist light!")
