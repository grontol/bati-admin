const arabicNumberMap = [
    "&\#1632;","&\#1633;","&\#1634;","&\#1635;","&\#1636;",
    "&\#1637;","&\#1638;","&\#1639;","&\#1640;","&\#1641;"
];

export function getArabicNumbers(n: number) {
    let newStr = ""

    const str = String(n)

    for(let i = 0; i < str.length; i++)
    {
        newStr += arabicNumberMap[parseInt(str.charAt(i))]
    }

    return newStr
}