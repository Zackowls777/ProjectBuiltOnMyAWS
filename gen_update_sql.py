def main():
    items = [f"  'seed/cover/quant-{i:02d}.jpg'" for i in range(1, 21)]
    elt = ",\n".join(items)

    print("SET @i:=0;")
    print("UPDATE channel")
    print("SET cover = ELT((@i:=@i+1) % 20 + 1,")
    print(elt)
    print(");")
    print()
    print("SET @j:=0;")
    print("UPDATE channel_section")
    print("SET cover = ELT((@j:=@j+1) % 20 + 1,")
    print(elt)
    print(");")


if __name__ == "__main__":
    main()
