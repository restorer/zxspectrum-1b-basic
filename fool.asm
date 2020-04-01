    device zxspectrum128

    org #8000

@first
    db #C7 ; RST #00
@last

    savebin "_build/fool-code.bin", @first, @last-@first
