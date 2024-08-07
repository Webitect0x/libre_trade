defmodule LibreTrade.ThreadsTest do
  use LibreTrade.DataCase

  alias LibreTrade.Threads

  describe "threads" do
    alias LibreTrade.Threads.Thread

    import LibreTrade.ThreadsFixtures

    @invalid_attrs %{name: nil, description: nil, logo: nil}

    test "list_threads/0 returns all threads" do
      thread = thread_fixture()
      assert Threads.list_threads() == [thread]
    end

    test "get_thread!/1 returns the thread with given id" do
      thread = thread_fixture()
      assert Threads.get_thread!(thread.id) == thread
    end

    test "create_thread/1 with valid data creates a thread" do
      valid_attrs = %{name: "some name", description: "some description", logo: "some logo"}

      assert {:ok, %Thread{} = thread} = Threads.create_thread(valid_attrs)
      assert thread.name == "some name"
      assert thread.description == "some description"
      assert thread.logo == "some logo"
    end

    test "create_thread/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Threads.create_thread(@invalid_attrs)
    end

    test "update_thread/2 with valid data updates the thread" do
      thread = thread_fixture()

      update_attrs = %{
        name: "some updated name",
        description: "some updated description",
        logo: "some updated logo"
      }

      assert {:ok, %Thread{} = thread} = Threads.update_thread(thread, update_attrs)
      assert thread.name == "some updated name"
      assert thread.description == "some updated description"
      assert thread.logo == "some updated logo"
    end

    test "update_thread/2 with invalid data returns error changeset" do
      thread = thread_fixture()
      assert {:error, %Ecto.Changeset{}} = Threads.update_thread(thread, @invalid_attrs)
      assert thread == Threads.get_thread!(thread.id)
    end

    test "delete_thread/1 deletes the thread" do
      thread = thread_fixture()
      assert {:ok, %Thread{}} = Threads.delete_thread(thread)
      assert_raise Ecto.NoResultsError, fn -> Threads.get_thread!(thread.id) end
    end

    test "change_thread/1 returns a thread changeset" do
      thread = thread_fixture()
      assert %Ecto.Changeset{} = Threads.change_thread(thread)
    end
  end

  describe "subscribtions" do
    alias LibreTrade.Threads.Subscription

    import LibreTrade.ThreadsFixtures

    @invalid_attrs %{}

    test "list_subscribtions/0 returns all subscribtions" do
      subscription = subscription_fixture()
      assert Threads.list_subscribtions() == [subscription]
    end

    test "get_subscription!/1 returns the subscription with given id" do
      subscription = subscription_fixture()
      assert Threads.get_subscription!(subscription.id) == subscription
    end

    test "create_subscription/1 with valid data creates a subscription" do
      valid_attrs = %{}

      assert {:ok, %Subscription{} = subscription} = Threads.create_subscription(valid_attrs)
    end

    test "create_subscription/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Threads.create_subscription(@invalid_attrs)
    end

    test "update_subscription/2 with valid data updates the subscription" do
      subscription = subscription_fixture()
      update_attrs = %{}

      assert {:ok, %Subscription{} = subscription} =
               Threads.update_subscription(subscription, update_attrs)
    end

    test "update_subscription/2 with invalid data returns error changeset" do
      subscription = subscription_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Threads.update_subscription(subscription, @invalid_attrs)

      assert subscription == Threads.get_subscription!(subscription.id)
    end

    test "delete_subscription/1 deletes the subscription" do
      subscription = subscription_fixture()
      assert {:ok, %Subscription{}} = Threads.delete_subscription(subscription)
      assert_raise Ecto.NoResultsError, fn -> Threads.get_subscription!(subscription.id) end
    end

    test "change_subscription/1 returns a subscription changeset" do
      subscription = subscription_fixture()
      assert %Ecto.Changeset{} = Threads.change_subscription(subscription)
    end
  end
end
