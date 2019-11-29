import beautiful


def test_init() -> None:
    assert beautiful

    assert isinstance(beautiful.__version_info__, tuple)
    assert beautiful.__version_info__
    assert isinstance(beautiful.__version__, str)
    assert len(beautiful.__version__)
